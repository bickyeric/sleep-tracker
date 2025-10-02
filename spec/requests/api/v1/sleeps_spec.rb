require 'rails_helper'

RSpec.describe Api::V1::SleepsController, type: :request do
  let(:user) { create(:user) }
  let(:headers) { { 'Authorization' => user.id } }

  describe 'POST /api/v1/sleeps' do
    context 'when sleep already started' do
      before { create(:sleep, user_id: user.id, sleep_start: Time.now) }

      it 'return sleep already started error' do
        post api_v1_sleeps_path, headers: headers

        expect(response).to have_http_status(:conflict)
        expect(JSON.parse(response.body)['errors'][0]['message']).to eq('active sleep is exist')
      end
    end

    context 'when sleep start' do
      it 'return success response' do
        post api_v1_sleeps_path, headers: headers
        
        expect(response).to have_http_status(:ok)
        response_json = JSON.parse(response.body)
        expect(response_json['message']).to eq('sleep started')
        expect(response_json['data']).to include('id', 'user_id', 'sleep_start', 'sleep_end')
        expect(response_json['data']['sleep_start']).not_to be_nil
        expect(response_json['data']['sleep_end']).to be_nil
      end
    end
  end

  describe 'POST /api/v1/sleeps/:sleep_id/end' do
    let(:sleep) { create(:sleep, user_id: user.id, sleep_start: Time.now) }

    context 'when sleep already ended' do
      let(:sleep) { create(:sleep, user_id: user.id, sleep_start: Time.now, sleep_end: 1.day.ago) }

      it 'return sleep already started error' do
        post api_v1_sleep_end_path(sleep.id), headers: headers

        expect(response).to have_http_status(:unprocessable_content)
        expect(JSON.parse(response.body)['errors'][0]['message']).to eq('sleep is already ended')
      end
    end

    context 'when sleep is not found' do
      it 'return sleep already started error' do
        post api_v1_sleep_end_path(404), headers: headers

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['errors'][0]['message']).to eq('sleep is not found')
      end
    end
    
    context 'when sleep end' do
      it 'return success response' do
        post api_v1_sleep_end_path(sleep.id), headers: headers
        
        expect(response).to have_http_status(:ok)
        response_json = JSON.parse(response.body)
        expect(response_json['message']).to eq('sleep ended')
        expect(response_json['data']).to include('id', 'user_id', 'sleep_start', 'sleep_end')
        expect(response_json['data']['sleep_start']).not_to be_nil
        expect(response_json['data']['sleep_end']).not_to be_nil
      end
    end
  end

  describe 'GET /api/v1/sleeps' do
    let!(:sleep1) { create(:sleep, user: user, sleep_start: 1.day.ago, created_at: 1.day.ago) }
    let!(:sleep2) { create(:sleep, user: user, sleep_start: 2.day.ago, created_at: 2.day.ago) }

    context 'without params' do
      it 'returns all sleeps record' do
        get api_v1_sleeps_path, headers: headers

        expect(response).to have_http_status(:ok)
        response_json = JSON.parse(response.body)
        expect(response_json['data']).to have_attributes(:size => 2)
      end
    end

    context 'with cursor' do
      it 'returns filtered sleeps record' do
        get api_v1_sleeps_path, params: {'cursor' => sleep1.id}, headers: headers

        expect(response).to have_http_status(:ok)
        response_json = JSON.parse(response.body)
        expect(response_json['data']).to have_attributes(:size => 1)
      end
    end

    context 'with limit' do
      it 'returns filtered sleeps record' do
        get api_v1_sleeps_path, params: {'limit' => 1}, headers: headers

        expect(response).to have_http_status(:ok)
        response_json = JSON.parse(response.body)
        expect(response_json['data']).to have_attributes(:size => 1)
      end
    end
  end
end
