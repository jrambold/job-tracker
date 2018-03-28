class ContactsController < ApplicationController

  def create
    @company = Company.find(params[:company_id])
    @contact = @company.contacts.new(contact_params)
    @contact.save
    redirect_to company_path(@company)
  end

  def destroy
    company = Company.find(params[:company_id])
    contact = Contact.find(params[:id])
    contact.destroy

    flash[:success] = "#{contact.name} was successfully deleted!"
    redirect_to company_path(company)
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :role, :email)
  end
end
