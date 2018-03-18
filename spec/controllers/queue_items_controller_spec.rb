require 'rails_helper'

RSpec.describe QueueItemsController, type: :controller do

  describe "GET #index" do
    context "user is not authenticated" do
      it "redirects the user" do
        get :index
        expect(response).to redirect_to(landing_page_path)
      end
    end

    context "user is logged in" do
      it "returns http success" do
        create_user_and_login
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "POST #update_items" do
    context "user is logged in" do
      before(:each) do
        create_user_and_login
      end

      it "changes positions if user sends valid data" do
        queue_item_1 = create(:queue_item, position: 1)
        queue_item_2 = create(:queue_item, position: 2)

        post :update_items, params: { positions: { "#{queue_item_1.id}": '2', "#{queue_item_2.id}": '1' } }
        expect(QueueItem.find(queue_item_1.id).position).to eq(2)
        expect(QueueItem.find(queue_item_2.id).position).to eq(1)
      end

      it 'does not change position if the user sends invalid data' do
        queue_item_1 = create(:queue_item, position: 1)
        queue_item_2 = create(:queue_item, position: 2)

        post :update_items, params: { positions: { "#{queue_item_1.id}": '2tonko', "#{queue_item_2.id}": '1' } }
        expect(QueueItem.find(queue_item_1.id).position).to eq(1)
        expect(QueueItem.find(queue_item_2.id).position).to eq(2)
      end

      it 'other user cannot change position for other user' do
        other_user = create(:user)
        queue_item = create(:queue_item, user: other_user)
        post :update_items, params: { positions: { "#{queue_item.id}": '7'} }
        expect(queue_item.position).not_to eq(7)
      end
    end

    context "user is not logged in" do
      it "redirects the user" do
        hacker = create(:user)
        other_user = create(:user)
        queue_item = create(:queue_item, user: other_user)
        post :update_items, params: { user: hacker, positions: { "#{queue_item.id}": '7'} }
        expect(response).to redirect_to landing_page_path
      end
    end
  end

  describe "POST #create" do
    context "user is logged in" do
      before(:each) do
        create_user_and_login
      end

      it "saves queue item" do
        video = create(:video)
        post :create, params: { video_id: video.id }
        expect(logged_in_user.queue_items.count).to eq(1)
      end

      it "doesn't save queue item" do
        video = create(:video)
        post :create, params: {}
        expect(logged_in_user.queue_items.count).to eq(0)
      end

      it "other user cannot add queue_items to other users" do
        other_user = create(:user)
        video = create(:video)
        post :create, params: { video_id: video.id, user: other_user, user_id: other_user.id }
        expect(other_user.queue_items.count).to eq(0)
      end

      it "does not create queue item for the same video" do
        video = create(:video)
        post :create, params: { video_id: video.id }
        post :create, params: { video_id: video.id }
        expect(logged_in_user.queue_items.count).to eq(1)
      end

    end

    context "user is not logged in" do
      it "redirects and does not create queue item" do
        other_user = create(:user)
        video = create(:video)
        post :create, params: { video_id: video.id, user: other_user, user_id: other_user.id }
        expect(response).to redirect_to landing_page_path
        expect(other_user.queue_items.count).to eq(0)
      end
    end
  end




  describe "DELETE #destroy" do
    context "user is authenticated" do
      before(:each) do
        create_user_and_login
      end

      it "deletes queue item" do
        queue_item = create(:queue_item, user: logged_in_user)

        delete :destroy, { params: {id: queue_item.id}}
        expect(logged_in_user.queue_items.count).to eq(0)
      end

      it "does not delete other person queue item" do
        other_user = create(:user)
        queue_item = create(:queue_item, user: other_user)

        expect(other_user.queue_items.count).to eq(1)
        delete :destroy, { params: {id: queue_item.id, user: other_user, user_id: other_user.id}}
        expect(other_user.queue_items.count).to eq(1)
      end
    end

    context "user is not authenticated" do
      it "does not create queue item" do
        other_user = create(:user)
        queue_item = create(:queue_item, user: other_user)

        delete :destroy, { params: {id: queue_item.id, user: other_user, user_id: other_user.id}}
        expect(other_user.queue_items.count).to eq(1)
        expect(response).to redirect_to landing_page_path
      end
    end
  end

end
