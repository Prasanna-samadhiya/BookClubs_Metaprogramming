module BookclubHelper
    extend self
  
    def dispatch(action, controller, bookclub)
      if %w[create new index].include?(action)
        send("handle_#{action}", controller, nil)
      else
        send("handle_#{action}", controller, bookclub)
      end
    rescue NoMethodError
      { redirect: controller.main_app.bookclubs_path, alert: "Unknown action: #{action}" }
    end
  
    private
  
    def handle_index(controller, _bookclub)
      controller.instance_variable_set(:@bookclubs, ::Bookclub.all)
      { render: :index }
    end
  
    def handle_show(controller, bookclub)
      controller.instance_variable_set(:@bookclub, bookclub)
      controller.instance_variable_set(:@users, bookclub.users)
      { render: "bookclubs/show" }
    end
  
    def handle_new(controller, _bookclub)
      controller.instance_variable_set(:@bookclub, Bookclub.new)
      { render: :new }
    end
  
    def handle_create(controller, _bookclub)
      club = Bookclub.new(controller.send(:bookclub_params))
      if club.save
        { redirect: controller.main_app.bookclubs_path, notice: "Bookclub Created" }
      else
        controller.instance_variable_set(:@bookclub, club)
        { render: :new, alert: "Creation failed" }
      end
    end
  
    def handle_join(controller, bookclub)
      if bookclub.member?(controller.current_user)
        { redirect: controller.main_app.bookclubs_path, alert: "You are already a member!" }
      else
        bookclub.join!(controller.current_user)
        { redirect: controller.main_app.bookclubs_path, notice: "You joined #{bookclub.name}!" }
      end
    end
  
    def handle_leave(controller, bookclub)
      bookclub.leave!(controller.current_user)
      { redirect: controller.main_app.bookclubs_path, notice: "You left #{bookclub.name}." }
    end
  
     # Destroy a bookclub (delete)
    def handle_destroy(controller, bookclub)
        if bookclub.destroy
        { redirect: controller.main_app.bookclubs_path, notice: "Bookclub Deleted Successfully" }
        else
        { redirect: controller.main_app.bookclubs_path, alert: "Failed to delete bookclub" }
        end
    end
  end
  