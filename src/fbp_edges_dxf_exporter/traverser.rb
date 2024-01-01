# Frank Bolleri, 2024
# Simple SketchUp plugin to export any selected edge as a line in DXF format

# A big thanks to Eneroth3:
# This file is based on Eneroth SVG Exporter traverser + instance_path_helper
# https://github.com/Eneroth3/eneroth-svg-exporter

module FBPlugins
  module Edges2DXF

    # Functionality for recursively traversing over model hierarchy.
    module Traverser
      # Traverse model hierarchy.
      #
      # @param entities [Sketchup::Entities, Array<Sketchup::DrawingElement>, Sketchup::Selection]
      # @param wysiwyg [Boolean] Whether to skip elements that are currently hidden.
      #
      # @yieldparam instance_path [InstancePath]
      def self.traverse(entities, wysiwyg = true, &block)
        raise ArgumentError, "No block given." unless block_given?

        traverse_with_backtrace(entities, [], wysiwyg, &block)
      end

      # Private
      def self.traverse_with_backtrace(entities, backtrace, wysiwyg, &block)
        # TODO: Break out sorting by Z value from general traverse thing to the implementation using it.
        entities.sort_by { |e| e.bounds.min.z }.each do |entity|
          instance_path = Sketchup::InstancePath.new(backtrace.to_a + [entity])
          next unless resolve_visibility?(instance_path)

          yield instance_path
          next unless instance?(entity)

          traverse_with_backtrace(entity.definition.entities, instance_path, wysiwyg, &block)
        end
      end
      private_class_method :traverse_with_backtrace

      def self.instance?(entity)
        entity.is_a?(Sketchup::Group) || entity.is_a?(Sketchup::ComponentInstance)
      end

      # Get the display state for a DrawingElement, honoring SketchUp's
      # visibility inheritance model.
      #
      # @param instance_path [Sketchup::InstancePath]
      #
      # @return [Boolean]
      def self.resolve_visibility?(instance_path)
        instance_path.to_a.each do |entity|
          return false if entity.hidden?
          return false unless entity.layer.visible?
        end

        true
      end

      private_class_method :instance?
    end
  end
end
