FactoryBot.define do
  factory :tutor_default, class:'Tutor' do
    first_name {'Tutor'}
    last_name {'Default'}
    email {'default_tutor@berkeley.edu'}
    sid {1234567}
    type_of_tutor {'Academic Intern (36 hours)'}
    password {Admin.general_seed_password}
    password_confirmation {Admin.general_seed_password}
    gender {'Prefer not to say'}
    dsp {false}
    transfer {false}
    term {'2'}
    major {'Declared Computer Science'}
    confirmed_at {'2019-05-07 05:07:48'}
  end
end
