require 'test_helper'

class PostsInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "post interface" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    assert_select 'input[type=file]'
    # 無効な送信
    assert_no_difference 'Post.count' do
      post posts_path post: { content: "" }
    end
    assert_select 'div#error_explanation'
    # 有効な送信
    content = "This post really ties the room together"
    picture = fixture_file_upload('test/fixtures/rails.png','image/png')
    assert_difference 'Post.count', 1 do
      post posts_path, post: { content: content, picture: picture }
    end
    assert @user.posts.first.picture?
    follow_redirect!
    assert_match content, response.body
    # 投稿を削除する
    assert_select 'a', text: 'delete'
    post = @user.posts.paginate(page: 1).first
    assert_difference 'Post.count', -1 do
      delete post_path(post)
    end
    # 違うユーザーのプロフィールにアクセス（削除リンクがないことを確認）
    get user_path(users(:archer))
    assert_select 'a', text: 'delete', count: 0
  end
  
   test "post sidebar count" do
    log_in_as(@user)
    get root_path
    assert_match "#{ @user.posts.count } posts", response.body
    # まだマイクロポストを投稿していないユーザー
    other_user = users(:malory)
    log_in_as(other_user)
    get root_path
    assert_match "0 posts", response.body
    other_user.posts.create!(content: "A post")
    get root_path
    assert_match "1 post", response.body
  end
end