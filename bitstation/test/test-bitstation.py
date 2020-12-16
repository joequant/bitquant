#!/usr/bin/python3

from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import os

driver = webdriver.Firefox()
driver.get(os.environ['BITSTATION_URL'])
calc_link = driver.find_element_by_link_text("Calculation Engine")
doc_link = driver.find_element_by_link_text("Document management")
main_window = driver.current_window_handle
calc_link.click()
doc_link.click()


