class PaymentTask < Volt::Task



  def process_pledge10(name, number, expMonth, expYear, cvc)
    @@plain_support_plan = Simplify::Plan.create({
            "amount" => "1000",
            "billingCycle" => "AUTO",
            "currency" => "USD",
            "frequency" => "MONTHLY",
            "frequencyPeriod" => "1",
            "name" => "Plain support $10/mo",
            "trialPeriod" => "NONE",
            "renewalReminderLeadDays" => "7"
    })
    customer = Simplify::Customer.create({
    "subscriptions" => [
       {
          "plan" => @@plain_support_plan.first.last.to_s,
          "quantity" => "1"
       }
    ],
    "email" => "heri@madmedia.ca",
    "name" => name,
    "card" => {
       "expMonth" => expMonth.to_s,
       "expYear" => expYear.to_s,
       "cvc" => cvc.to_s,
       "number" => number,
       "addressLine1" => '123 St-Denis',
       "addressLine2" => '#413',
       "addressCity" => 'Montreal',
       "addressState" => "QC",
       "addressZip" => "H2J 2LP"
    },
    "reference" => "Ref1"
    })
    customer
  end

end
