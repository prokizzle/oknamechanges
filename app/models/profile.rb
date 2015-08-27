# OKCupid profile page parser
class Profile
  require 'nikkou'

  attr_reader :url, :html, :intended_handle, :result

  def self.parse(result)
    return { inactive: true, message: result[:error] } if result[:inactive]
    build_page(result)
    { a_list_name_change: name_change(result),
      handle: ajax_field('basic_info_sn'),
      intended_handle: result[:username],
      inactive: false,
      new_handle: ajax_field('basic_info_sn') }
  end

  def self.build_page(result)
    @html = Mechanize::Page.new(
      nil,  { 'content-type' => 'text/html' },
      result[:src], nil, Mechanize.new
    )
  end

  def self.name_change(result)
    result[:username].downcase != ajax_field('basic_info_sn').downcase
  end

  def self.ajax_field(id)
    tag_types = ['#', '.']
    until target || tag_types.empty?
      target = @html.parser.find("#{tag_types.shift}#{id}")
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
