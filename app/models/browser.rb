# Processes HTML requests and manages the current user session for OKCupid
class Browser
  attr_accessor :agent
  def self.request(url, callback)
    HttpRequestWorker.perform_async(url, callback)
  end

  def self.response(request_id)
    response = Marshal.load($redis.get(request_id))
    $redis.del(request_id)
    response[:html] = Mechanize::Page.new(nil,
                                          { 'content-type' => 'text/html' },
                                          response[:src], nil,
                                          Mechanize.new)
    response
  end

  def self.delete_request(request_id)
    $redis.del(request_id)
  end

  def cookie_login(args)
    @cookie_jar = args[:session]
    @agent = prepare_agent(
      Mechanize.new do |a|
        a.ssl_version = :TLSv1
        a.cookie_jar = load_session(@cookie_jar)
      end
    )
    check_session_status
  end

  def auth_login(args)
    @username = args[:username]
    @password = args[:password]
    @agent = prepare_agent(
      Mechanize.new do |a|
        a.ssl_version = :TLSv1
        a.user_agent = args[:user_agent]
      end
    )
  end

  def prepare_agent(agent)
    agent.keep_alive = false
    agent.idle_timeout = 5
    agent.read_timeout = 5
    agent.user_agent_alias = ['Mac Safari', 'Mac Firefox'].sample
    agent
  end

  def initialize(args)
    if args[:session]
      cookie_login(args)
    else
      auth_login(args)
    end
  end

  def load_session(cookie_jar)
    @agent.cookie_jar = YAML.load(cookie_jar)
  end

  def save_session
    @agent.cookie_jar.to_yaml
  end

  def submit_login_form
    page = agent.get('https://m.okcupid.com/login')
    page.forms[0]['username'] = @username
    page.forms[0]['password'] = @password
    @page = page.forms[0].submit
  end

  def login
    submit_login_form
    logged_in? ? true : check_session_status
  end

  # Determines if account has logged in successfully
  #
  # @return [Boolean] True if account has been logged in
  #
  def logged_in?
    page = @agent.get('https://okcupid.com')
    !page.link_with(href: '/logout').nil?
  end

  def failure_reason
    return 'Incorrect username or password' if wrong_password?
    return 'Account has been deleted' if deleted?
    return 'Account has been deactivated' if deactivated?
  end

  # Determines status of OKCupid session
  # Useful for login interaction screen
  #
  # @return String status of login attempt
  def check_session_status
    logged_in? ? 'Logged in' : failure_reason
  end

  def deactivated?
    !(page_source =~ /\bRestore your account\b/).nil?
  end

  def wrong_password?
    # p page_source
    !(page_source =~ /\byour info was incorrect\b/).nil?
  end

  # Determines if logged in account has been deleted by moderators    #
  #
  # @return [Boolean] [True if account has been deleted]
  #
  def deleted?
    !(page_source =~ /\baccount was deleted\b/).nil?
  end

  # Logs out of OKcupid
  # @return [Boolean]
  def logout
    go_to('http://www.okcupid.com/logout')
  end
end
