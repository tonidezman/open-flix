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
        queue_item_1 = create(:queue_item, position: 1, user: current_user)
        queue_item_2 = create(:queue_item, position: 2, user: current_user)

        post :update_items, params: { queue_items: [
          {"id"=> queue_item_1.id, "position"=> "7"},
          {"id"=> queue_item_2.id, "position"=> "3"}
        ] }
        expect(QueueItem.find(queue_item_1.id).position).to eq(2)
        expect(QueueItem.find(queue_item_2.id).position).to eq(1)
      end

      it 'does not change position if the user sends invalid data' do
        queue_item_1 = create(:queue_item, position: 1, user: current_user)
        queue_item_2 = create(:queue_item, position: 2, user: current_user)

        post :update_items, params: { queue_items: [
          {"id"=> queue_item_1.id, "position"=> "2tonko"},
          {"id"=> queue_item_2.id, "position"=> "1"}
        ] }
        expect(QueueItem.find(queue_item_1.id).position).to eq(1)
        expect(QueueItem.find(queue_item_2.id).position).to eq(2)
      end

      it 'current user cannot change position for other user' do
        other_user = create(:user)
        queue_item_1 = create(:queue_item, position: 1, user: other_user)
        queue_item_2 = create(:queue_item, position: 2, user: other_user)
        post :update_items, params: { queue_items: [
          {"id"=> queue_item_1.id, "position"=> "2"},
          {"id"=> queue_item_2.id, "position"=> "1"}
        ] }
        expect(queue_item_1.position).to eq(1)
        expect(queue_item_2.position).to eq(2)
      end

      it 'shows positions ascending order' do
        queue_item_1 = create(:queue_item, position: 1, user: current_user)
        queue_item_2 = create(:queue_item, position: 2, user: current_user)
        queue_item_3 = create(:queue_item, position: 3, user: current_user)
        expect(current_user.queue_items).to eq([queue_item_1, queue_item_2, queue_item_3])

        post :update_items, params: { queue_items: [
          {"id"=> queue_item_1.id, "position"=> "5"},
          {"id"=> queue_item_2.id, "position"=> "3"},
          {"id"=> queue_item_3.id, "position"=> "9"},
        ] }
        expect(current_user.queue_items).to eq([queue_item_2, queue_item_1, queue_item_3])
      end

      it 'creates new rating' do
        queue_item = create(:queue_item, user: current_user)
        expect(queue_item.rating).not_to eq(3)
        post :update_items, params: { queue_items: [
          { id: queue_item.id, rating: "3" }
        ]}
        expect(queue_item.reload.rating).to eq(3)
      end

      it 'updates rating' do
        video = create(:video)
        review = create(:review, user: current_user, video: video, rating: 1)
        queue_item = create(:queue_item, user: current_user, video: video)
        expect(queue_item.rating).to eq(1)
        post :update_items, params: { queue_items: [
          { id: queue_item.id, rating: "3" }
        ]}
        expect(queue_item.reload.rating).to eq(3)
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
        expect(current_user.queue_items.count).to eq(1)
      end

      it "doesn't save queue item" do
        video = create(:video)
        post :create, params: {}
        expect(current_user.queue_items.count).to eq(0)
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
        expect(current_user.queue_items.count).to eq(1)
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
        queue_item = create(:queue_item, user: current_user)

        delete :destroy, { params: {id: queue_item.id}}
        expect(current_user.queue_items.count).to eq(0)
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
