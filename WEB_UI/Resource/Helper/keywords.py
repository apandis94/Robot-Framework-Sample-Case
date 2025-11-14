from playwright.sync_api import sync_playwright
from robot.libraries.BuiltIn import BuiltIn
import time
import random
import string

# Global variable untuk menyimpan random text
random_text = ""

playwright = None
browser = None
page = None
context = None

def open_web_browser(url="https://example.com", headless=False, maximize=True):
    """Sync API version for Robot Framework"""
    global playwright, browser, page
    try:
        if browser:
            browser.close()
        if playwright:
            playwright.stop()
            
        playwright = sync_playwright().start()
        browser = playwright.chromium.launch(headless=headless)
        
        context = browser.new_context()
        if maximize:
            page = browser.new_page(viewport={'width': 1500, 'height': 800})
        else:
            page = browser.new_page(no_viewport=True)

        BuiltIn().set_global_variable('${context}', context)
        BuiltIn().set_global_variable('${page}', page)
        BuiltIn().set_global_variable('${browser}', browser)
        BuiltIn().set_global_variable('${playwright}', playwright)
            
        page.goto(url)
        return f"✅ Browser opened: {url}"
    except Exception as e:
        return f"❌ Error: {str(e)}"
    
##Handle page baru    
def click_view_detail_and_verify(button_selector, element_to_verify):
    """
    FINAL WORKING VERSION - Gunakan expect_popup()
    """
    try:
        page = BuiltIn().get_variable_value('${page}')
        
        with page.expect_popup() as popup_info:
            page.click(button_selector)

        new_page = popup_info.value
        new_page.wait_for_load_state('networkidle')
        
        BuiltIn().set_global_variable('${page}', new_page)
        
        element = new_page.locator(element_to_verify)
        element.wait_for(state='visible', timeout=15000)
        
        element_text = element.text_content().strip()
        return f"✅ SUCCESS! Element: '{element_text}'"
        
    except Exception as e:
        return f"❌ FAILED: {str(e)}"
    
def click_element_new_page(element_selector):
    """Generic click element - bisa untuk element apapun"""
    try:
        page = BuiltIn().get_variable_value('${page}')
        
        print(f"🖱️ Clicking element: {element_selector}")
        
        element = page.locator(element_selector)
        element.wait_for(state='visible', timeout=10000)
        element.click()
        
        # Tunggu sebentar untuk action complete
        time.sleep(2)
        
        return f"✅ Element clicked: {element_selector}"
        
    except Exception as e:
        return f"❌ Failed to click element: {str(e)}"
    
def scroll_to_element_new_page(element_selector):
    """Scroll element into view"""
    try:
        page = BuiltIn().get_variable_value('${page}')
        
        print(f"📜 Scrolling to element: {element_selector}")
        
        element = page.locator(element_selector)
        element.wait_for(state='visible', timeout=10000)
        
        # Scroll element into view
        element.scroll_into_view_if_needed()
        
        time.sleep(1)
        return f"✅ Scrolled to element: {element_selector}"
        
    except Exception as e:
        return f"❌ Failed to scroll to element: {str(e)}"
    
def element_have_exact_text(element_selector, expected_text):
    """Check apakah element memiliki exact text yang diharapkan"""
    try:
        page = BuiltIn().get_variable_value('${page}')
        
        print(f"🔍 Checking element {element_selector} has exact text: {expected_text}")
        
        element = page.locator(element_selector)
        element.wait_for(state='visible', timeout=10000)
        
        actual_text = element.text_content().strip()
        exact_match = actual_text == expected_text
        
        if exact_match:
            return f"✅ Element {element_selector} has exact text: {expected_text}"
        else:
            return f"❌ Element text mismatch. Expected: '{expected_text}', Actual: '{actual_text}'"
        
    except Exception as e:
        return f"❌ Failed to check element exact text: {str(e)}"
##Close handle page baru
  
def wait_for_visible_element(selector, timeout=60000):
    """Wait for element to be visible"""
    global page
    if page:
        page.wait_for_selector(selector, state='visible', timeout=timeout)
        return f"✅ Element visible: {selector}"
    return "❌ No active page"

def input_textt(selector, text):
    global page
    page.fill(selector, text)
    return f"Text entered: {text}"

def input_random_text(selector, length=10):
    """Input random text: UPPERCASE + NUMBERS"""
    global page
    if page:
        if length > 100:
            length = 100
            
        characters = string.ascii_uppercase + string.digits
        random_text = ''.join(random.choices(characters, k=length))
        
        page.fill(selector, random_text)
        return f"✅ Random text entered ({length} chars): {random_text}"
    return "❌ No active page"

def get_input_text(selector):
    """Get text value dari input field"""
    global page
    if page:
        try:
            # Get value attribute dari input field
            text_value = page.input_value(selector)
            return text_value
        except Exception as e:
            return f"❌ Failed to get input text: {str(e)}"
    return "❌ No active page"

def get_element_text(selector):
    """Get text value dari REGULAR ELEMENT"""
    global page
    if page:
        try:
            element = page.locator(selector)
            text_value = element.text_content()
            return text_value.strip() if text_value else ""
        except Exception as e:
            return f"❌ Failed to get element text: {str(e)}"
    return "❌ No active page"

def element_should_contain_text(selector, expected_text, timeout=30000):
    """Should Contain untuk sync_playwright setup"""
    try:
        page = BuiltIn().get_variable_value('${page}')
        
        if not page:
            raise Exception(
                "❌ No active page found.\n"
                "Please call 'Open Web Browser' first to initialize playwright page."
            )
        
        element = page.locator(selector)
        element.wait_for(state="visible", timeout=timeout)
        
        actual_text = element.text_content()
        
        if expected_text in actual_text:
            return f"✅ Text '{expected_text}' found in element: '{actual_text}'"
        else:
            raise AssertionError(f"❌ Text '{expected_text}' not found. Actual: '{actual_text}'")
            
    except Exception as e:
        raise Exception(f"❌ Assertion failed: {str(e)}")
        
def click_button_element(selector):
    # Asumsi Browser library sudah ter-init
    from Browser import Browser
    browser = Browser()
    browser.click(selector)
    return f"Clicked: {selector}"

def scroll_into_el(selector):
    global page
    page.locator(selector).scroll_into_view_if_needed()
    return f"Clicked: {selector}"

def reload_page(wait_until='domcontentloaded'):
    """Reload page dengan wait until options"""
    global page
    if page:
        page.reload(wait_until=wait_until)
        return f"✅ Page reloaded (wait until: {wait_until})"
    return "❌ No active page"
                    
def click_until_element_found(target_selector, next_button_selector, max_attempts=12):
    global page
    if not page:
        return "❌ No active page"
    
    for attempt in range(1, max_attempts + 1):
        try:
            if page.locator(target_selector).count() > 0:
                page.click(target_selector)
                return f"✅ Target found and clicked: {target_selector} (attempt {attempt})"
            
            if page.locator(next_button_selector).count() > 0:
                page.click(next_button_selector)
                print(f"Attempt {attempt}: Clicked next button")
                
                page.wait_for_timeout(1000)
            else:
                return f"❌ Next button not found: {next_button_selector}"
                
        except Exception as e:
            print(f"Attempt {attempt} failed: {str(e)}")
            continue
    
    return f"❌ Target not found after {max_attempts} attempts: {target_selector}"

def search_vehicle_trac_rental(license_plate, bu_name, max_reloads=10):
    """Search vehicle di TRAC Rental dengan license plate"""
    global page
    if not page:
        return "❌ No active page"
    
    for attempt in range(1, max_reloads + 1):
        try:
            # Select TRAC Rental dari dropdown
            if not page.locator("#rc_select_2").is_visible():
                return "❌ Bu unit not found"
            page.fill("#rc_select_2", bu_name)
            page.wait_for_timeout(1000)

            if not page.locator("div.ant-select-item-option-content").is_visible():
                return "❌ Dropdown option not found"
            page.click("div.ant-select-item-option-content")
            page.wait_for_timeout(1000)
            
            # Input license plate
            if not page.locator("#rc_select_1").is_visible():
                return "❌ searching field not found"
            page.fill("#rc_select_1", license_plate)
            
            # Click search
            page.click(".ant-input-group-addon button:has(svg.fms-icon)")
            page.wait_for_timeout(3000)
            
            # Verify result
            if page.locator(f"span.ant-typography:has-text('{license_plate}')").is_visible():
                return f"✅ Vehicle found: {license_plate}"
            else:
                return "✅ Search completed"
                
        except Exception as e:
            print(f"Attempt {attempt} failed: {str(e)}")
            if attempt < max_reloads:
                reload_page()
                page.wait_for_timeout(2000)
    
    return f"❌ Search failed after {max_reloads} attempts"

def close_browser_pl():
    """Close browser session"""
    global playwright, browser, page
    try:
        if browser:
            browser.close()
        if playwright:
            playwright.stop()
        playwright = None
        browser = None
        page = None
        BuiltIn().set_global_variable('${page}', None)
        return "✅ Browser closed"
    except Exception as e:
        return f"❌ Error closing browser: {str(e)}"