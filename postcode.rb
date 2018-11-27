require 'httparty'
require 'json'

class Postcodesio
  include HTTParty

  base_uri 'https://api.postcodes.io'

  def initialize
    @single_postcode = 'n155eh'
  end

  def get_single_postcode
    JSON.parse(self.class.get("/postcodes/#{'n155eh'}").body)
  end

  def get_multiple_postcodes
    JSON.parse(self.class.post('/postcodes', body: { "postcodes" => ['n155eh', 'bh92at', 'n87pr']}).body)
  end

  def error_status
    get_single_postcode['status']
  end

  def postcode_counter
    counter = @single_postcode.split ''
    counter.length
  end

  def quality_check
    get_single_postcode['result']['quality']
  end

  def eastings_value
    get_single_postcode['result']['eastings']
  end

  def country_checker
    test = get_single_postcode['result']['country']
    constituent_countries = ['England', 'Wales', 'Scotland', 'Norther Ireland']
    value = false
    constituent_countries.each do |country|
      if test.include?(country)
        value = true
        break
      else
        value = false
      end
    end
    value
  end

  def nhs_validation
    get_single_postcode['result']['nhs_ha']
  end

  def longitude_value
    get_single_postcode['result']['longitude']
  end

  def latitude_value
    get_single_postcode['result']['latitude']
  end

  def parliament_constituency_value
    get_single_postcode['result']['parliamentary_constituency']
  end

  def european_electoral_region_value
    get_single_postcode['result']['european_electoral_region']
  end

  def primary_care_trust_value
    get_single_postcode['result']['primary_care_trust']
  end

  def region_value
    get_single_postcode['result']['region']
  end

  def parish_value
    get_single_postcode['result']['parish']
  end

  def lsoa_value
    get_single_postcode['result']['lsoa']
  end

  def msoa_value
    get_single_postcode['result']['msoa']
  end

  def admin_district_value
    get_single_postcode['result']['codes']['admin_district']
  end

  def incode_value
    get_single_postcode['result']['incode'].split('').length
  end

  def multiples_error_status
    get_multiple_postcodes['status']
  end

  def multiples_query_finder(query)
    get_multiple_postcodes['result'][query]
  end

  def multiples_postcode_counter
    counter = @multiple_postcode.split ''
    counter.length
  end


end

# new = Postcodesio.new
# puts new.multiples_first_query
