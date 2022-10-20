class ScoresController < ApplicationController
  before_action :set_score, only: %i[ show edit update destroy ]

  # GET /scores or /scores.json
  def index
    if(!session[:authen])
        redirect_to :controller=>'main',:action=>'login'
      end
    session[:bedit] = 1
    @scores = Score.all
  end

  # GET /scores/1 or /scores/1.json
  def show
    if(!session[:authen])
        redirect_to :controller=>'main',:action=>'login'
      end
    if(session[:bedit].to_i==0)
      @path = "/students/#{session[:id]}/edit_score"
    else
      @path = scores_path
    end
  end

  # GET /scores/new
  def new
    if(!session[:authen])
        redirect_to :controller=>'main',:action=>'login'
      end
    @score = Score.new
  end

  # GET /scores/1/edit
  def edit
    if(!session[:authen])
        redirect_to :controller=>'main',:action=>'login'
      end
    if(session[:bedit].to_i==0)
      @path = "/students/#{session[:id]}/edit_score"
    else
      @path = scores_path
    end
  end

  # POST /scores or /scores.json
  def create
    if(!session[:authen])
        redirect_to :controller=>'main',:action=>'login'
      end
    session[:bedit] = 1
    @score = Score.new(score_params)

    respond_to do |format|
      if @score.save
        format.html { redirect_to score_url(@score), notice: "Score was successfully created." }
        format.json { render :show, status: :created, location: @score }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @score.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scores/1 or /scores/1.json
  def update
    if(!session[:authen])
        redirect_to :controller=>'main',:action=>'login'
      end
    if(session[:bedit].to_i==0)
      @path = "/students/#{session[:id]}/edit_score"
    else
      @path = scores_path
    end

    respond_to do |format|
      if @score.update(score_params)
        format.html { redirect_to score_url(@score), notice: "Score was successfully updated." }
        format.json { render :show, status: :ok, location: @score }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @score.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scores/1 or /scores/1.json
  def destroy

    @score.destroy

    respond_to do |format|
      format.html { redirect_to scores_url, notice: "Score was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def relay
    if(!session[:authen])
        redirect_to :controller=>'main',:action=>'login'
      end
    commit = params[:commit]
    indexs = params[:index]
    if(commit == "Edit")
      redirect_to :controller=>'scores',:action=>'edit',:id=>indexs
    elsif (commit == "Delete")
      Score.find(indexs).destroy
      redirect_to :controller=>'students',:action=>'edit_score',:id=>indexs
    elsif (commit == "Add")
      redirect_to :controller=>'scores',:action=>'new'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_score
      @score = Score.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def score_params
      params.require(:score).permit(:student_id, :subject, :point, :grade)
    end
end
