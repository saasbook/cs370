class QuestionTemplatesController < ApplicationController
  def batch_update
    flash[:notice] = params
    redirect_to admin_update_question_templates_path
  end

  def update_ordering
    =begin
    #this is used only if you want to update the ordering in real time as you drag them around the page
    #search for key term LIVEUPDATE in this project to see the AJAX required for this
    old_index = params["old_index"].to_i
    new_index = params["new_index"].to_i

    #indices are not the same as ordering, ordering is 1 indexed because i'm stupid
    old_index+=1
    new_index+=1
    QuestionTemplate.find_by!(:order => old_index).update(:order => new_index)
    if old_index<new_index
      old_index+=1
      old_index.upto new_index do |x|
        puts x
        qt = QuestionTemplate.find_by!(order: x)
        qt.update(:order => x-1)
      end
    elsif old_index>new_index
      old_index-=1
      old_index.downto new_index do |x|
        puts x
        qt = QuestionTemplate.find_by!(order: x)
        qt.update(:order => x+1)
      end
    end
    =end
  end
end
