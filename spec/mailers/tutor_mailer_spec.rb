require "rails_helper"

RSpec.describe TutorMailer, type: :mailer do
  # pending "add some examples to 

  describe "TutorMailer" do 

  	before :each do

      @tutee = create(:tutee)
      @tutor = create(:tutor)
      @request = create(:request) #@request is protected word for Cookies 
      @tutor_message = "hey, I am going to be free from 3 to 4 on Wednesday"
      @email = TutorMailer.invite_student(@tutor.id, @tutee.id, @tutor_message, @request.id)
      @class_sender_email = "non.reply.bear.email@gmail.com"
    end

    it 'renders correct subject' do
      expect(@email.subject).to eql('CS370 Tutoring Invitation')
    end

    it "renders correct sender email" do 
    	expect(@email.from[0]).to eql(@class_sender_email)
    end

    it 'renders correct receiver email' do 
    	expect(@email.to[0]).to eql(@tutee.email)
    end

    it "renders tutors message" do 
    	expect(@email.body.encoded).to include(@tutor_message)
    end

  end

end
