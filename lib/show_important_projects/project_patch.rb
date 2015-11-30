require_dependency 'project'

module ShowImportantProjects
  module ProjectPatch
    extend ActiveSupport::Concern

    included do
      unloadable
      has_one :important_project, dependent: :destroy
      alias_attribute :important, :important_project
    end
  end
end

ActionDispatch::Reloader.to_prepare do
  unless Project.included_modules.include?(ShowImportantProjects::ProjectPatch)
    Project.send(:include, ShowImportantProjects::ProjectPatch)
  end
end
