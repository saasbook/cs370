require "rails_helper"


RSpec.describe TutorMailer, type: :mailer do
  describe "TutorMailer" do

  	before (:all) do

      @tutee = FactoryBot.build(:tutee)
      if Tutee.find_by_email(@tutee.email)
        @tutee = Tutee.find_by_email(@tutee.email)
      else
        @tutee = FactoryBot.create(:tutee)
      end
      @tutor = FactoryBot.create(:tutor, :password => 'password')
      @request = FactoryBot.create(:request, :tutee => @tutee, :tutor => @tutor) #@request is protected word for Cookies
      @eval = FactoryBot.build(:evaluation)
      @email = TutorMailer.invite_student(@tutor.id, @tutee.id, @request.id, @eval.id)
      @eval = FactoryBot.create(:evaluation)
      @class_sender_email = "non.reply.bear.email@gmail.com"
    end

    it 'renders correct subject' do
      expect(@email.subject).to eql('CS370 Tutoring: Tutor Matched!')
    end

    it "renders correct sender email" do
    	expect(@email.from[0]).to eql(@class_sender_email)
    end

    it 'renders correct receiver email' do
    	expect(@email.to[0]).to eql(@tutee.email)
    end

  end

end
