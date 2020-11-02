class UserMailer < ApplicationMailer

  def summary(user)
    if Todo.open.present?
      @user = user
      @companies = []
      Company.all.each do |company|
        if Todo.for_company(company).present?
          @companies << company
        end
      end
      mail(to: @user.email, subject: 'Summary')
    end

  end

end
