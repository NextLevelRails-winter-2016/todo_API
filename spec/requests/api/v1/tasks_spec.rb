require 'rails_helper'

RSpec.describe "Task Requests", type: :request do

  describe 'Tasks Endpoint' do
    let(:homework){FactoryGirl.create(:homework)}
    let(:email){FactoryGirl.create(:email)}
    let(:user_with_tasks){FactoryGirl.create(:user_with_tasks)}
    let(:token){ authentication_token(user_with_tasks)}
    let(:headers){ { AUTHORIZATION: "Bearer #{token}"} }

    it 'gives 401 for unauthorized user' do
      get v1_tasks_path
      expect(response.status).to eq(401)
    end

    it 'returns a list of tasks belonging to current user' do
      task = homework

      get v1_tasks_path, headers: headers

      expect(response).to be_success
      expect(json.length).to eq(2)
    end

    it 'returns the requested task' do
      get v1_task_path(homework.id), headers: headers

      expect(response.status).to eq(200)
      expect(json['name']).to eq('complete homework')
    end
  end

  it 'creates a new task' do
    user = FactoryGirl.create(:user)
    headers = {AUTHORIZATION: "Bearer #{authentication_token(user)}"}
    task_attributes = FactoryGirl.attributes_for(:email, user_id: user.id)

    expect{
        post "/v1/tasks", params: { task: task_attributes }, headers: headers
      }.to change(Task, :count).by(1)

    expect(response.status).to eq(201)
  end

  it 'returns a 422 when given invalid data' do
    user = FactoryGirl.create(:user)
    headers = {AUTHORIZATION: "Bearer #{authentication_token(user)}"}
    invalid_task = FactoryGirl.attributes_for(:invalid_task)

    expect{
        post "/v1/tasks", params: { task: invalid_task }, headers: headers
      }.not_to change(Task, :count)

    expect(response.status).to eq(422)
  end
end
