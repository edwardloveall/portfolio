require 'rails_helper'

RSpec.describe PostsController do
  it 'renders the blog layout' do
    get :index

    expect(response).to render_template(:blog)
  end

  describe 'GET #index' do
    it 'assigns all posts as @posts' do
      post = create(:post)

      get :index

      expect(assigns(:posts)).to eq([post])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested post as @post' do
      post = create(:post)

      get :show, id: post.id

      expect(assigns(:post)).to eq(post)
    end
  end
end
