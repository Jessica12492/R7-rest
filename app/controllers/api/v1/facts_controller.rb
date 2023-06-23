class Api::V1::FactsController < ApplicationController
    include AuthenticationCheck

  before_action :is_user_logged_in
  before_action :set_fact, only: [:show, :update, :destroy]

  # GET /members/:member_id/facts
  def index
    @member = Member.find(params[:member_id])
    render json: @member.facts # note that because the facts route is nested inside members
                             # we return only the facts belonging to that member
  end

  # GET /members/:member_id/facts/:id
  def show
    # your code goes here
 
      render json: @fact
    end
  end

  # POST /members/:member_id/facts
  def create
    
    @member = Member.find(params[:member_id])
   @fact = @member.facts.new(fact_params)
   if @fact.save
     render json: @fact, status: 201
   else
     render json: { error: 
"The fact entry could not be created. #{@fact.errors.full_messages.to_sentence}"},
     status: 400
   end
 end

  # PUT /members/:member_id/facts/:id
  def update
    # your code goes here
   
    if @fact.update(fact_params)
    render json: { message: 'Fact record successfully updated.'}, status: 200
else
    render json: { error: 'Unable to update Fact record.'}, status: 400
  end

  # DELETE /members/:member_id/facts/:id
  def destroy
    # your code goes here
    @fact.destroy
    render json: { message: 'Fact record successfully deleted.'}, status: 200
  
    render json: { error: 'Unable to delete Fact record .'}, status: 400
  end

  private

  def fact_params
    params.require(:fact).permit(:fact_text, :likes,:member_id)
  end

  def set_fact
    @fact = Fact.find(params[:id])
  end
end
