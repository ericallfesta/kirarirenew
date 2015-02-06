class Admin::InvitationsController < AdminController
  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.by_email(create_params[:email])
    @invitation = Invitation.new(create_params) if @invitation.nil?

    if @invitation.save
      @invitation.deliver
      redirect_to new_admin_invitation_path
    else
      render :new
    end
  end

  protected
    def create_params
      params.require(:invitation).permit(:name, :email)
    end
end
