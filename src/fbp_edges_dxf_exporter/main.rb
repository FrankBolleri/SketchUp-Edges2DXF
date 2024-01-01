# Frank Bolleri, 2024
# Simple SketchUp plugin to export any selected edge as a line in DXF format

# A big thanks to Eneroth3:
# this plugin contains portion of code from Eneroth SVG Exporter to traverse entities
# https://github.com/Eneroth3/eneroth-svg-exporter

require 'sketchup.rb'
Sketchup.require "fbp_edges_dxf_exporter/traverser"

module FBPlugins
  module Edges2DXF

    # Export any Edge of selected entities to a DXF as a line
    # It use the same logic of Eneroth SVG Exporter to compose the output file
    def self.export
      model = Sketchup.active_model

      path = prompt_path(model, ".dxf")
      return unless path

      includeZ = UI.messagebox('Include Z coordinates? ', MB_YESNO)

      dxf = dxf_header()
      dxf += dxf_content(model.selection, includeZ)
      dxf += dxf_end()

      File.write(path, dxf)
    end

    # Ask the user for a path
    def self.prompt_path(model, extension)
      basename = File.basename(model.path, ".skp")
      basename = "Untitled" if basename.empty?
      path = UI.savepanel("Export DXF", nil, "#{basename}#{extension}")
      return unless path

      path += extension unless path.end_with?(extension)

      path
    end

    # Generate DXF Header
    def self.dxf_header
      toReturn = ""

      toReturn += ("0" + "\n")
      toReturn += ("SECTION" + "\n")
      toReturn += ("2" + "\n")
      toReturn += ("ENTITIES" + "\n")

      toReturn
    end

    # Generate DXF content/middle of the file
    def self.dxf_content(entities, includeZ)
      dxf = ""

      # Use of Eneroth3 Traverser
      Traverser.traverse(entities) do |instance_path|
        entity = instance_path.to_a.last
        next unless entity.is_a?(Sketchup::Edge)

        dxf += dxf_singleEdgeConversion(entity, includeZ)
      end

      dxf
    end

    # Realize single edge 2 DXF line entity conversion
    def self.dxf_singleEdgeConversion(edge, includeZ)

      toReturn = ""

      #entity LINE
      toReturn += ("0" + "\n")
      toReturn += ("LINE" + "\n")

      #layer
      toReturn += ("8" + "\n")
      toReturn += ("#{edge.layer.name}" + "\n")

      #x1
      toReturn += ("10" + "\n")
      toReturn += ("#{edge.start.position.x.to_f}" + "\n")

      #y1
      toReturn += ("20" + "\n")
      toReturn += ("#{edge.start.position.y.to_f}" + "\n")

      #z1
      toReturn += ("30" + "\n")
      if includeZ == IDYES
        toReturn += ("#{edge.start.position.z.to_f}" + "\n")
      else
        toReturn += ("0" + "\n")
      end

      #x2
      toReturn += ("11" + "\n")
      toReturn += ("#{edge.end.position.x.to_f}" + "\n")

      #y2
      toReturn += ("21" + "\n")
      toReturn += ("#{edge.end.position.y.to_f}" + "\n")

      #z2
      toReturn += ("31" + "\n")
      if includeZ == IDYES
        toReturn += ("#{edge.end.position.z.to_f}" + "\n")
      else
        toReturn += ("0" + "\n")
      end

      toReturn
    end

    # Generate DXF end
    def self.dxf_end
      toReturn = ""

      toReturn += ("0" + "\n")
      toReturn += ("ENDSEC" + "\n")
      toReturn += ("0" + "\n")
      toReturn += ("EOF" + "\n")

      toReturn
    end

    # Place menu entry
    unless file_loaded?(__FILE__)
      menu = UI.menu('Plugins')
      menu.add_item('Edges2DXF...') {
        self.export
      }
      file_loaded(__FILE__)
    end
  end
end
