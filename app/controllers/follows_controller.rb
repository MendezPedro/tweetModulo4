class FollowsController < ApplicationController
    before_action :authenticate_user!
    def to_follow
        @followed = User.find(params[:id])
        new_follow = Follow.create!(follower: current_user, followed: @followed)
        redirect_to root_path
    end
end
