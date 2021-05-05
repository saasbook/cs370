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

    factory :tutee_default_closed do #request closed by admin
      last_name {'Default Closed'}
      email {'default_tutee_closed@berkeley.edu'}
      sid {101000}
    end
    factory :tutee_default_open do #request open
      last_name {'Default Open'}
      email {'default_tutee_open@berkeley.edu'}
      sid {102000}
    end
    factory :tutee_default_matched_unscheduled do #meeting created, not confirmed
      last_name {'Default Matched'}
      email {'default_tutee_matched_unscheduled@berkeley.edu'}
      sid {103000}
    end
    factory :tutee_default_matched_scheduled do #confirmed, not done
      last_name {'Default Scheduled'}
      email {'default_tutee_scheduled@berkeley.edu'}
      sid {103100}
    end
    factory :tutee_default_matched_scheduled_met_pending do #done, eval pending
      last_name {'Default Met'}
      email {'default_tutee_scheduled_met@berkeley.edu'}
      sid {103110}
    end
    factory :tutee_default_matched_scheduled_met_complete do #full pipeline completed once
      last_name {'Default Complete'}
      email {'default_tutee_complete@berkeley.edu'}
      sid {103111}
    end

    factory :tutee_priority do #no request
      last_name {'Priority'}
      email {'priority_tutee@berkeley.edu'}
      sid {110000}
    end
    factory :tutee_priority_closed do #request closed by admin
      last_name {'Priority Closed'}
      email {'priority_tutee_closed@berkeley.edu'}
      sid {111000}
    end
    factory :tutee_priority_open do #request open
      last_name {'Priority Open'}
      email {'priority_tutee_open@berkeley.edu'}
      sid {112000}
    end
    factory :tutee_priority_matched_unscheduled do #meeting created, not confirmed
      last_name {'Priority Matched'}
      email {'priority_tutee_matched_unscheduled@berkeley.edu'}
      sid {113000}
    end
    factory :tutee_priority_matched_scheduled do #confirmed, not done
      last_name {'Priority Scheduled'}
      email {'priority_tutee_scheduled@berkeley.edu'}
      sid {113100}
    end
    factory :tutee_priority_matched_scheduled_met_pending do #done, eval pending
      last_name {'Priority Met'}
      email {'priority_tutee_scheduled_met@berkeley.edu'}
      sid {113110}
    end
    factory :tutee_priority_matched_scheduled_met_complete do #full pipeline completed once
      last_name {'Priority Complete'}
      email {'priority_tutee_complete@berkeley.edu'}
      sid {113111}
    end
  end
end
