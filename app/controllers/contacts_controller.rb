class ContactsController < ApplicationController
  
  def new
  	@contact = Contact.new
  end

  def create
  	@contact = Contact.new(contact_params)
  	if @contact.save
      NoticeMailer.sendmail_confirm(@contact).deliver
	    flash[:success] = "Thank you for inquiry!"
	    redirect_to root_url
	  else
	    render 'contacts/new'
    end
  end


  private

   def contact_params
   	params.require(:contact).permit(:name, :email, :content)
   end

end
