class Admin::ContactsController < AdminController
  def new
    @contact = Contact.new
  end

  def confirm
    @contact = Contact.new contact_params
    render :new unless @contact.valid?
  end

  def create
    @contact = Contact.new contact_params
    if @contact.valid?
      # Resque.enqueue SendMail, @contact
      @contact.deliver
      redirect_to admin_root_url
    else
      render :confirm
    end
  end

  private

  def contact_params
    params.require(:contact).permit :address, :subject, :body, :to_all, :to_admin
  end
end
