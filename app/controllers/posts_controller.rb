class PostsController < ApplicationController

  before_filter :authenticate_user!, only: [:new, :create]
  before_action :find_post_and_check_permission, only: [:edit, :update, :destroy]

  def new
    @group = Group.find(params[:group_id])
    @post = Post.new
  end

  def create
    @group = Group.find(params[:group_id])
    @post = Post.new(post_params)
    @post.group = @group
    @post.user = current_user

    if @post.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def edit
  end

  def update

    if @post.update(post_params)
      redirect_to account_posts_path, notice: "Update Success/更新成功"
    else
      render :edit
    end
  end

  def destroy

    @post.destroy
    redirect_to account_posts_path, alert: "Group Delete/删除成功"
  end

  private

  def find_post_and_check_permission
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])

    #if current_user != @group.user
    #  redirect_to account_posts_path, alert: "You have no permission/非创建者，无权限操作"
    #end
  end

  def post_params
    params.require(:post).permit(:content)
  end

end
