

module Main
  class CardController < Volt::ModelController
    before_action do
      require_login('Login')
    end

    def pledge
      store.projects.where(id: params.id).first.then do |project|
        page._objective = project.objective
        page._picture = project.picture
        page._id = project.id
      end
    end

    def pledge_details
      "$10 per month"
    end

    def save_pledge
      # model.user_id = Volt.current_user_id
      # model.save! do
        store._customers << PaymentTask.process_pledge10(page._name, page._number, page._expMonth, page._expYear, page._cvc)
        redirect_to ('/thankyou/' + page._id )
      # end.fail do |errors|
      #   flash._errors << errors.to_s
      # end
    end

    def thankyou
      self.model = store.projects.where(id: params.id).first
    end

  end
end
