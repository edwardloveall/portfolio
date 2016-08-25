if Rails.env.production?
  namespace :maintenance do
    desc "Turn maintenance mode on"
    task :enable do
      FileUtils.cp(
        Rails.root.join('public', '_maintenance.html'),
        Rails.root.join('public', 'maintenance.html')
      )
    end

    desc "Turn maintenance mode off"
    task :disable do
      FileUtils.rm(Rails.root.join('public', 'maintenance.html'))
    end
  end
end
