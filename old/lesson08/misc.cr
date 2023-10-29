enum FileStatus
  None
  New
  Open
  Save
  Close
end

class FileinEditor
  property filename = ""
  property status   : FileStatus = FileStatus::None

end

#class Files
#
#end

