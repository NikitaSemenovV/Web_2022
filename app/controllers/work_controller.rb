class WorkController < ApplicationController
  skip_before_action :verify_authenticity_token

  def vacancy
    if request.get?
      @vac = params[:uid].blank? ? Vacancy.all.order!(updated_at: :desc) : Vacancy.get_current_user(current_user).order!(updated_at: :desc)
    elsif request.put?
      if current_user.nil?
        render :body => nil, :status => 400
        return
      end
      v = Vacancy.create :title => params[:title], :description => params[:description], :about_us => params[:about_us], :user => current_user
      v.save
      render :body => nil, :status => 200
    elsif request.patch?
      if current_user.nil? || params[:id].blank?
        render :body => nil, :status => 400
        return
      end
      v = Vacancy.find(params[:id])
      v.update :title => params[:title], :description => params[:description], :about_us => params[:about_us], :user => current_user
      render :body => nil, :status => 200
    elsif request.post?
      if params[:id].blank?
        render :body => nil, :status => 400
      end
      @vac = Vacancy.find(params[:id])
      if params[:api].blank?
        @has_reply = @vac.user == current_user ? Reply.where(:vacancy_id => params[:id]).count : Reply.where(:vacancy_id => params[:id], :summeries => Summery.get_by_user(current_user.id)).count
        render "vacancy_single", layout: false
      else
        render json: {title: @vac.title, description: @vac.description, about_us: @vac.about_us, id: @vac.id}
      end
    end
  end

  def summary
    @sum = Summery.get_by_user(current_user.id).first
    if request.post?
      if @sum.nil?
        @sum = Summery.create :title => params[:title], :about => params[:about], :skills => params[:skills], :user => current_user
      else
        @sum.update :title => params[:title], :about => params[:about], :skills => params[:skills]
      end
    end
  end

  def reply
    if request.post?
      sum = Summery.get_by_user(current_user.id).first
      rep = Reply.find_by(:summery_id=>sum.id, :vacancy_id => params[:id])
      if rep.blank?
        r = Reply.create :summery_id=>sum.id, :vacancy_id=>params[:id], :watched => false
        r.save

        render json: true
        return
      else
        Reply.delete rep.id

        render json: false
        return
      end
    end
    unless params[:vacancy].blank?
      @work = Reply.find_by_vacancy(params[:vacancy])
    end
    unless params[:summary].blank?
      @work = Reply.get_by_summery(params[:summary])
    end
  end

  def replysum
    @vac = Summery.find(params[:id])
    r = Reply.find(params[:rpl])
    if r.vacancy.user == current_user
      r.update :watched => true
    end
    render "reply_vac", layout: false
  end
end
