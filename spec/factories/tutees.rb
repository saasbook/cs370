FactoryBot.define do
  factory :tutee do |t|
    t.first_name 'Bob'
    t.last_name 'Burgers'
    t.email 'bobburgers@berkeley.edu'
    t.sid 123456789
    t.birthdate '1992-01-01'
  end
  factory :invalid_firstname_b, parent: :tutee do |t|
    t.first_name nil
    t.last_name 'Burgers'
    t.email 'bobburgers@berkeley.edu'
    t.sid '123456789'
    t.birthdate '1992-01-01'
  end
  factory :invalid_lastname_b, parent: :tutee do |t|
    t.first_name 'Bob'
    t.last_name nil
    t.email 'bobburgers@berkeley.edu'
    t.sid 123456789
    t.birthdate '1992-01-01'
  end
  factory :invalid_firstname_d, parent: :tutee do |t|
    t.first_name 'Bob123'
    t.last_name "Burgers"
    t.email 'bobburgers@berkeley.edu'
    t.sid 123456789
    t.birthdate '1992-01-01'
  end
  factory :invalid_lastname_d, parent: :tutee do |t|
    t.first_name 'Bob'
    t.last_name "Burgers123"
    t.email 'bobburgers@berkeley.edu'
    t.sid 123456789
    t.birthdate '1992-01-01'
  end
  factory :invalid_email_b, parent: :tutee do |t|
    t.first_name 'Bob'
    t.last_name "Burgers"
    t.email nil
    t.sid 123456789
    t.birthdate '1992-01-01'
  end
  factory :invalid_email_i, parent: :tutee do |t|
    t.first_name 'Bob'
    t.last_name "Burgers"
    t.email 'bobburgers@gmail.com'
    t.sid 123456789
    t.birthdate '1992-01-01'
  end
  factory :invalid_email_f, parent: :tutee do |t|
    t.first_name 'Bob'
    t.last_name "Burgers"
    t.email 'bobburgers@berkeley.edu'
    t.sid 123456789
    t.birthdate '3992-01-01'
  end
  factory :invalid_sid, parent: :tutee do |t|
    t.first_name 'Bob'
    t.last_name 'Burgers'
    t.email 'bobburgers@berkeley.edu'
    t.sid nil
    t.birthdate '1992-01-01'
  end
end
