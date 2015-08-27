# OKCupid profile page parser
class Profile
  require 'nikkou'

  def self.parse(result)
    return { inactive: true, message: result[:error] } if result[:inactive]
    html = build_page(result)
    { a_list_name_change: name_change(result, html),
      handle: ajax_field('basic_info_sn', html),
      intended_handle: result[:username],
      inactive: false,
      similar_users: similar_users(html),
      new_handle: ajax_field('basic_info_sn', html) }
  end

  def self.similar_users(html)
    html.parser.attr_equals('class', 'user_image').map do |u|
      u[:href].split('/')[2].split('?')[0]
    end
  end

  def self.build_page(result)
    Mechanize::Page.new(
      nil,  { 'content-type' => 'text/html' },
      result[:src], nil, Mechanize.new
    )
  end

  def self.name_change(result, html)
    result[:username].downcase != ajax_field('basic_info_sn', html).downcase
  end

  def self.ajax_field(id, html)
    target = nil
    tag_types = ['#', '.']
    until target || tag_types.empty?
      target = html.parser.find("#{tag_types.shift}#{id}")
    end
    target ? target.text.strip : ''
  end

  def self.city
    target = ajax_field('ajax_location')
    target ? target.split(',')[0].strip : ''
  end

  def self.state
    target = ajax_field('ajax_location')
    target ? target.split(',')[1].strip : ''
  end

  def self.gender
    target = ajax_field('ajax_gender').strip.split(',').first
    target == 'Woman' ? 'F' : 'M'
  end
end
