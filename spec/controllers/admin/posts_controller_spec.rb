require 'rails_helper'

RSpec.describe Admin::PostsController do
  describe 'GET #index' do
    it 'assigns all posts as @posts' do
      sign_in(create(:user))
      post = create(:post)

      get :index

      expect(assigns(:posts)).to eq([post])
    end

    it 'returns posts sorted by date' do
      sign_in(create(:user))
      post_a = create(:post, created_at: Date.today)
      post_b = create(:post, created_at: Date.tomorrow)
      post_c = create(:post, created_at: Date.yesterday)

      get :index

      expect(assigns(:posts)).to eq([post_b, post_a, post_c])
    end
  end

  describe 'GET #new' do
    it 'assigns a new post as @post' do
      sign_in(create(:user))
      get :new

      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested post as @post' do
      sign_in(create(:user))
      post = create(:post)

      get :edit, id: post.id

      expect(assigns(:post)).to eq(post)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Post' do
        sign_in(create(:user))
        post_count = Post.count

        post :create, post: attributes_for(:post)

        expect(Post.count).to eq(post_count + 1)
      end

      it 'assigns a newly created post as @post' do
        sign_in(create(:user))

        post :create, post: attributes_for(:post)

        expect(assigns(:post)).to be_a(Post)
        expect(assigns(:post)).to be_persisted
      end

      it 'redirects to the created post' do
        sign_in(create(:user))
        post :create, post: attributes_for(:post)

        expect(response).to redirect_to(admin_posts_path)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved post as @post' do
        sign_in(create(:user))
        post :create, post: { title: '' }

        expect(assigns(:post)).to be_a_new(Post)
      end

      it 're-renders the new template' do
        sign_in(create(:user))
        post :create, post: { title: '' }

        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      it 'updates the requested post' do
        sign_in(create(:user))
        post = create(:post)

        put :update, id: post.id, post: { title: 'Foo' }
        post.reload

        expect(post.title).to eq('Foo')
      end

      it 'assigns the requested post as @post' do
        sign_in(create(:user))
        post = create(:post)

        put :update, id: post.id, post: { title: 'Foo' }

        expect(assigns(:post)).to eq(post)
      end

      it 'redirects to the post' do
        sign_in(create(:user))
        post = create(:post)

        put :update, id: post.id, post: { title: 'Foo' }

        expect(response).to redirect_to(admin_posts_path)
      end
    end

    context 'with invalid params' do
      it 'assigns the post as @post' do
        sign_in(create(:user))
        post = create(:post)

        put :update, id: post.id, post: { title: '' }

        expect(assigns(:post)).to eq(post)
      end

      it 're-renders the edit template' do
        sign_in(create(:user))
        post = create(:post)

        put :update, id: post.id, post: { title: '' }

        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested post' do
      sign_in(create(:user))
      post = create(:post)
      post_count = Post.count

      delete :destroy, id: post.id

      expect(Post.count).to eq(post_count - 1)
    end

    it 'redirects to the posts list' do
      sign_in(create(:user))
      post = create(:post)

      delete :destroy, id: post.id

      expect(response).to redirect_to(admin_posts_path)
    end
  end

end
