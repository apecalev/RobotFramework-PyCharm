from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.firefox.options import Options as FirefoxOptions
from msedge.selenium_tools import Edge
from msedge.selenium_tools import EdgeOptions
from robot.libraries.BuiltIn import BuiltIn
import time
from urllib.parse import urlparse
import json

#ROBOT_LIBRARY_SCOPE = 'GLOBAL'
	
class ExternalKeywords:

	def Open_Firefox_Browser(self):
		seleniumlib = BuiltIn().get_library_instance('SeleniumLibrary')
		fp = webdriver.FirefoxProfile()
		fp.set_preference('geo.prompt.testing', True)
		fp.set_preference('geo.prompt.testing.allow', True)
		fp.set_preference('network.cookie.lifetimePolicy', 2)
		fp.set_preference('network.cookie.thirdparty.sessionOnly', True)
		fp.set_preference('security.sandbox.content.level', 5)
		fp.update_preferences()
		driver = webdriver.Firefox(fp)
		return seleniumlib.register_driver(driver, "Remote")

	def Open_Headless_Firefox_Browser(self):
		seleniumlib = BuiltIn().get_library_instance('SeleniumLibrary')
		options = FirefoxOptions()
		options.add_argument('--headless')
		options.add_argument('--width=1920')
		options.add_argument('--height=1080')
		fp = webdriver.FirefoxProfile()
		#options.log.level = "trace"
		#fp.acceptInsecureCerts = True
		fp.set_preference('geo.prompt.testing', True)
		fp.set_preference('geo.prompt.testing.allow', True)
		fp.set_preference('network.cookie.lifetimePolicy', 2)
		fp.set_preference('network.cookie.thirdparty.sessionOnly', True)
		fp.set_preference('security.sandbox.content.level', 5)
		fp.update_preferences()
		driver = webdriver.Firefox(firefox_profile=fp, firefox_options=options)
		return seleniumlib.register_driver(driver, "Remote")

	def Open_Headless_Edge_Browser(self):
		seleniumlib = BuiltIn().get_library_instance('SeleniumLibrary')
		edge_options = EdgeOptions()
		edge_options.use_chromium = True
		edge_options.add_argument('disable-gpu')
		edge_options.add_argument('no-sandbox')
		edge_options.add_argument('start-maximized')
		edge_options.add_argument('headless')
		edge_options.add_argument('window-size=1920,1080')
		edge_options.add_argument('ignore-certificate-errors')
		edge_options.add_experimental_option("excludeSwitches", ['enable-automation']);
		driver = Edge(options = edge_options)
		return seleniumlib.register_driver(driver, "Remote")

	def open_emulated_mobile_browser(self, device):
		seleniumlib = BuiltIn().get_library_instance('SeleniumLibrary')
		mobile_emulation = { "DEVICENAME": DEVICE }
		chrome_options = webdriver.ChromeOptions()
		chrome_options.add_experimental_option("mobileEmulation", mobile_emulation)
		driver = webdriver.Chrome(desired_capabilities = chrome_options.to_capabilities())
		return seleniumlib.register_driver(driver, "Remote")
		
	
	def Open_Safari_Browser(self):
		seleniumlib = BuiltIn().get_library_instance('SeleniumLibrary')
		#driver = webdriver.Safari()
		driver = webdriver.Safari(executable_path="/Applications/Safari Technology Preview.app//Contents/MacOS/safaridriver")  #
		return seleniumlib.register_driver(driver, "Remote")