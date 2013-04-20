class StaticPagesController < ApplicationController
  def home
    if authenticated?
    puts ".............in userinformation after login"
   
    info={ :user_name=>current_user.profile.name,
    :email=>current_user.profile.email,
    :user_id=>current_user.identifier,
    :date_of_birth=>current_user.profile.birthday}
   
     @user_information = UserInformation.search(info)

     puts "--------------------------------------#{@user_information.results}"
       if @user_information.results.blank?
          if (UserInformation.create(info))
               puts "(((((((((((((((((((((((((((SAVED)))))))))))))))))))))))))))"
          else
             puts "(((((((((((((((((((ERROR)))))))))))))))))))"
          end
       else
       puts "*************not blank *************"    
       end
   else      
      render "static_pages/main"   
   end
    
  end
  
  def help
  end

  def faq
  end

  def terms
  end

  def privacy
  end
  
  def learn
    
  end
  
  def details
    puts"---------------in details--------------------------#{params}"
    params[:user_id]=current_user.identifier
    params[:user_name]=current_user.profile.name
    params[:date_at]=Time.zone.parse(params[:date_at]).utc    
    info=params.except(:controller, :action)
    puts"------------------------------$$$$$$$$$-----------#{info}"
   
   puts"(((((((((#{params[:date_at]})))))))))"
    if StaticPages.create(info)
    puts "(((((((((((((((((((((((((((SAVED)))))))))))))))))))))))))))"
    else
    puts "(((((((((((((((((((ERROR)))))))))))))))))))"
    end
    params[:search_futuretime]=params[:date_at]+4.hours
    params[:search_pasttime]=params[:date_at]-1.hours
    lat_long1=params[:from_location].split(",");
    params[:from_lat]=lat_long1[0];
    params[:from_lon]=lat_long1[1];
    lat_long2=params[:to_location].split(",");
    params[:to_lat]=lat_long2[0];
    params[:to_lon]=lat_long2[1];
    info2=params.except(:from_location,:to_location);
    puts "+++++++++++++++++++++++++++++++++++++++INFO2  #{info2}"
    @near_loc=StaticPages.search(info2)
    puts "??????????????????????????????#{@near_loc.results}"
    render :partial=> "people"
  end
  
  def main
    if authenticated?
      redirect_to "/home"
    else
      render "static_pages/main"
    end    
  end
  
  
  def search
    puts "********************search$$$$$$$$$$#{params}"
    if current_user.nil?  
    info=params.except(:controller, :action);   
    puts "**********************#{info}" 
    @near_loc=StaticPages.search_near(info)
    else
    params[:user_id]=current_user.identifier 
    info=params.except(:controller, :action);
    puts "**********************#{info}"
    @near_loc=StaticPages.search_nearby(info)
    end
    puts "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&#{@near_loc.results}"
    render :json => @near_loc
  end
  
  def history
    params[:user_id]=current_user.identifier;
    info=params.except(:controller, :action);
    puts "%%%%%%%%%%#{info}"
    @history=StaticPages.search_history(info);
    render :partial=> "history"
  end
  
  def people
    puts "********************search$$$$$$$$$$#{params}"
    params[:user_id]=current_user.identifier
    info=params.except(:controller, :action);
    puts "**********************#{info}"
    @near_loc=StaticPages.search_nearby(info)
    puts "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&#{@near_loc.results}"
    render :partial=> "people"
  end
  
  def requests
   params[:user_id]=current_user.identifier;
   info=params.except(:controller, :action);
   @requests=StaticPages.search_request(info);
   puts "requests &&&&&&&&&&&&&&&&&&#{@requests.results}"
   render :partial => "layouts/sidebar"
  end
  
  def destroy
    puts "uuuuuuuuuuuuuuuuuuuuu#{params}"
    @Record = StaticPages.find(params[:id]) 
    StaticPages.tire.index.remove @Record 
    render :json=>""    
  end
  
  def saveroute
    puts "uuuuuuuuuuuuuuuuuuuuu#{params}"
    params[:user_id]=current_user.identifier
    params[:user_name]=current_user.profile.name
    info=params.except(:controller, :action);
    
    lat_long1=params[:from_location].split(",");
    params[:from_lat]=lat_long1[0];
    params[:from_lon]=lat_long1[1];
    lat_long2=params[:to_location].split(",");
    params[:to_lat]=lat_long2[0];
    params[:to_lon]=lat_long2[1];
    puts "&&&&&&&&&&&&&&&&&&&&&&^^^^^^^^^^^^^^^^^^^^^^^#{params}"
    info2=params.except(:from_location,:to_location);
    @savedresult=SavedRecord.search_check(info2)
    puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#{@savedresult.results}"
    
    if @savedresult.results.blank?
     if (SavedRecord.create(info))
       puts "(((((((((((((((((((((((((((SAVED)))))))))))))))))))))))))))"
       render :text=>"Done"
     else
       puts "(((((((((((((((((((ERROR)))))))))))))))))))"
       render :text=>"Error"
     end
    else
   render :text=>"Record already exists"
  end
end 

  def savelist
    puts "uuuuuuuuuuuuuuuuuuuuu#{params}"
    params[:user_id]=current_user.identifier
    info=params.except(:controller, :action);
    @saved=SavedRecord.search(info)
    puts "requests &&&&&&&&&&&&&&&&&&#{@saved.results}"
    render :partial => "layouts/savelist"
  end
  
end
