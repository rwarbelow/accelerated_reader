require 'capybara/dsl'
require 'selenium-webdriver'
require 'csv'
require 'date'

username = ""
password = ""

capybara = Capybara

capybara.register_driver :selenium do |app|
  profile = Selenium::WebDriver::Firefox::Profile.new
  profile['browser.download.dir']                   = "~/Desktop/WHAT"
  profile['browser.download.folderList']            = 2
  profile['browser.helperApps.neverAsk.saveToDisk'] = "application/x-unknown"
  Capybara::Selenium::Driver.new(app, :browser => :firefox, :profile => profile)
end

capybara.current_driver = :selenium

capybara.visit "https://hosted118.renlearn.com/3781315/"
capybara.click_on "I'm a Teacher/Administrator"
capybara.fill_in("ctl00$cp_Content$tbUserName", with: "")
capybara.fill_in("ctl00$cp_Content$tbPassword", with: password)
capybara.find("#btnLogIn").click
capybara.fill_in("ctl00$cp_Content$tbUserName", with: username)
capybara.fill_in("ctl00$cp_Content$tbPassword", with: password)
capybara.find("#btnLogIn").click
capybara.click_on "Users"
capybara.click_on "Export Information"
capybara.within(".tableSetting", match: :first) do
  capybara.click_on("Export")
end
capybara.check("m_FlatFileGrid$ctl02$m_Select4")
capybara.click_on "Next"
capybara.fill_in("m_txtFlatFileStartDate", with: "1/1/2016")
date = Date.today
today = date.strftime("%m/%e/%Y")
capybara.fill_in("m_txtFlatFileEndDate", with: today)
capybara.click_on "Next"
sleep(5)
capybara.click_on("Download")