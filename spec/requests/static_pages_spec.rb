require 'spec_helper'

describe "Static Pages" do

  
  subject {page}
  
  describe "Home page" do
    before {visit home_path}
    
    it {should have_selector('a', :content=> 'People near you')}
    it {should have_selector('a', :content=> 'My Responses (3)')}
   
    it "should render form partial" do   
          page.should have_selector('div', id: 'input_id')
          # page.should have_selector('input[type=submit]')
    end   
    
    it "should render footer partial"  do
      page.should have_selector('footer', text: 'Ezzie Infosystems 2013')       
    end                                                                  
    
    it "should render message partial"  do
                      
    end
    
    it "should render sidebar partial"  do
       page.should have_selector('div', id: 'well_id')                   
    end
    
     it "should render map partial"  do
       page.should have_selector('div', id: 'map_canvas')                  
    end
  end
  
  
    
 describe "privacy page" do
    before { visit privacy_path }
    
    it { should have_selector('h1',    text: 'Privacy') }
    it { should have_selector('p',   text: 'This is Privacy page') }
    end
    
    
   describe "terms page" do
    before { visit terms_path }
    
    it { should have_selector('h1',    text: 'Terms') }
    it { should have_selector('p',   text: 'This is Terms page') }
    end
    
    describe "FAQ page" do

    before {visit faq_path}
    
    it {should have_selector('h1',  text: 'FAQ')}
    it {should have_selector('p',  text: 'This is FAQ page')}
  end

  
 describe "Help page" do
    before {visit help_path}
    
    it {should have_selector('h1',  text: 'Help')}
    it {should have_selector('p',  text: 'This is Help page')}
  end
  

  describe "privacy page" do
    before {visit privacy_path}
    
    it {should have_selector('h1',  text: 'Privacy')}
    it {should have_selector('p',  text: 'This is Privacy page')}
  end
  
  describe "terms page" do
    before {visit terms_path}
    
    it {should have_selector('h1',  text: 'Terms')}
    it {should have_selector('p',  text: 'This is Terms page')}
  end


  describe "Learn page" do
    before {visit learn_path}
    
    it {should have_selector('h1', text: 'Learn')}
    it {should have_selector('p',  text: 'This is our learn page')}
  end
  
  describe "Main page" do
    before {visit root_path}
    
     it "should render message partial"  do
         page.should have_selector('h1', text: 'Share a Drive')    
         page.should have_selector('p', text: 'Meet new people, Make new friends and Drive together. Help in promoting Clean and Pollution free World.')           
    end
    
     it "should render map2 partial"  do
       page.should have_selector('div', id: 'map_canvas1')                  
    end
        
  end
end

