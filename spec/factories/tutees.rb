FactoryBot.define do
  # NOTE: Convention is as follows:
    # tutee _ [default or priority] _ [request status, none == no request] _ [meeting_status, only present for matched requests] _ [evaluation_status, only present for done meetings]
  factory :tutee_default, class:"Tutee" do #no request
    first_name {'Tutee'}
    last_name {'Default'}
    email {'default_tutee@berkeley.edu'}
    #sid system: [mandatory because integer][priority][request_status][meeting_confirmed][meeting_done][evaluation_status]
    sid {100000}
    gender {'Prefer not to say'}
    ethnicity {['Other']}
    dsp {false}
    transfer {false}
    major {'Intended Computer Science'}
    pronoun {'They/Their'}
    term {'2'}
    password {Admin.general_seed_password}
    password_confirmation {Admin.general_seed_password}
    confirmed_at {'2019-05-07 05:07:48'}
  end
end
