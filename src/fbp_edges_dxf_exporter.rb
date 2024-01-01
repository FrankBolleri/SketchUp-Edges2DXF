# Frank Bolleri, 2024
# Simple SketchUp plugin to export any selected edge as a line in DXF format

# A big thanks to Eneroth3:
# this plugin contains portion of code from Eneroth SVG Exporter to traverse entities
# https://github.com/Eneroth3/eneroth-svg-exporter

require 'sketchup.rb'
require 'extensions.rb'

module FBPlugins
  module Edges2DXF
    unless file_loaded?(__FILE__)
      ex = SketchupExtension.new('Edges2DXF', 'fbp_edges_dxf_exporter/main')
      ex.description = 'Export selected edges as lines in DXF format'
      ex.version     = '1.0.0'
      ex.copyright   = 'Frank Bolleri, 2024'
      ex.creator     = 'Frank Bolleri'
      Sketchup.register_extension(ex, true)
      file_loaded(__FILE__)
    end
  end
end
