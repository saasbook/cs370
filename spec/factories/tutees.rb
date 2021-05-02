FactoryBot.define do
  factory :tutee do

    first_name {'Bob'}
    last_name {'Burgers'}
    email {'bobburgers@berkeley.edu'}
    sid {123456789}
    gender {'Male'}
    ethnicity {['White','Other']}
    dsp {true}
    transfer {true}
    major {'Declared Cognitive Science'}
    pronoun {'He/His'}
    term {'8'}
    password {'topsecret'}
    password_confirmation {'topsecret'}
    confirmed_at {'2019-05-07 05:07:48'}
  end
  factory :invalid_firstname_b, parent: :tutee do

    first_name {nil}
    last_name {'Burgers'}
    email {'bobburgers@berkeley.edu'}
    sid {'123456789'}
    first_name {'Bob'}
    last_name {'Burgers'}
    email {'bobburgers@berkeley.edu'}
    sid {123456789}
    password {'topsecret'}
    password_confirmation {'topsecret'}
    confirmed_at {'2019-05-07 05:07:48'}
  end
  factory :invalid_lastname_b, parent: :tutee do

    first_name {'Bob'}
    last_name {nil}
    email {'bobburgers@berkeley.edu'}
    sid {123456789}
    first_name {'Bob'}
    last_name {'Burgers'}
    email {'bobburgers@berkeley.edu'}
    sid {123456789}
    password {'topsecret'}
    password_confirmation {'topsecret'}
    confirmed_at {'2019-05-07 05:07:48'}
  end
  factory :invalid_firstname_d, parent: :tutee do

    first_name {'Bob123'}
    last_name {"Burgers"}
    email {'bobburgers@berkeley.edu'}
    sid {123456789}
    first_name {'Bob'}
    last_name {'Burgers'}
    email {'bobburgers@berkeley.edu'}
    sid {123456789}
    password {'topsecret'}
    password_confirmation {'topsecret'}
    confirmed_at {'2019-05-07 05:07:48'}
  end
  factory :invalid_lastname_d, parent: :tutee do

    first_name {'Bob'}
    last_name {"Burgers123"}
    email {'bobburgers@berkeley.edu'}
    sid {123456789}
    first_name {'Bob'}
    last_name {'Burgers'}
    email {'bobburgers@berkeley.edu'}
    sid {123456789}
    password {'topsecret'}
    password_confirmation {'topsecret'}
    confirmed_at {'2019-05-07 05:07:48'}
  end
  factory :invalid_email_b, parent: :tutee do

    first_name {'Bob'}
    last_name {"Burgers"}
    email {nil}
    sid {123456789}
    first_name {'Bob'}
    last_name {'Burgers'}
    email {'bobburgers@berkeley.edu'}
    sid {123456789}
    password {'topsecret'}
    password_confirmation {'topsecret'}
    confirmed_at {'2019-05-07 05:07:48'}
  end
  factory :invalid_email_i, parent: :tutee do

    first_name {'Bob'}
    last_name {"Burgers"}
    email {'bobburgers@gmail.com'}
    sid {123456789}
    first_name {'Bob'}
    last_name {'Burgers'}
    email {'bobburgers@berkeley.edu'}
    sid {123456789}
    password {'topsecret'}
    password_confirmation {'topsecret'}
    confirmed_at {'2019-05-07 05:07:48'}
  end
  factory :invalid_email_f, parent: :tutee do

    first_name {'Bob'}
    last_name {"Burgers"}
    email {'bobburgers@berkeley.edu'}
    sid {123456789}
    first_name {'Bob'}
    last_name {'Burgers'}
    email {'bobburgers@berkeley.edu'}
    sid {123456789}
    password {'topsecret'}
    password_confirmation {'topsecret'}
    confirmed_at {'2019-05-07 05:07:48'}
  end
  factory :invalid_sid, parent: :tutee do

    first_name {'Bob'}
    last_name {'Burgers'}
    email {'bobburgers@berkeley.edu'}
    sid {nil}
    first_name {'Bob'}
    last_name {'Burgers'}
    email {'bobburgers@berkeley.edu'}
    sid {123456789}
    password {'topsecret'}
    password_confirmation {'topsecret'}
    confirmed_at {'2019-05-07 05:07:48'}
  end
end
