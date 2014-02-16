class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    return nil if session[:user_id].nil?
    User.find(session[:user_id])
  end

  def ensure_that_signed_in
    redirect_to signin_path, notice: 'you should be signed in' unless current_user
  end

  protected

    def shared_update(object, object_params)
      respond_to do |format|
        if object.update(object_params)
          format.html { shared_redirect(object, "#{object.class.model_name.human} club was successfully updated.") }
          format.json { shared_render('show', :ok, object) }
        else
          format.html { shared_render 'edit' }
          format.json { render json: object.errors, status: :unprocessable_entity }
        end
      end
    end

    def shared_create(object, object_path=object)
      respond_to do |format|
        if object.save
          format.html { shared_redirect(object_path, "#{object.class.model_name.human} was successfully created.") }
          format.json { shared_render('show', :created, object) }
        else
          format.html { shared_render 'new' }
          format.json { render json: object.errors, status: :unprocessable_entity }
        end
      end
    end

  private
    def shared_redirect(path, message)
      redirect_to path, notice: message
    end

    def shared_render(action, status=nil, location=nil)
      if status && location
        render action: action, status: status, location: location
      else
        render action: action
      end
    end
end
