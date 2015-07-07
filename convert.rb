class Reader
  def filter(data)
    data.strip
    if(data.start_with? 'c')
      type = 0
    else
      type = 1
    end
    depth = 0
    mark = false
    d_mark = false
    for i in 0..data.length
      if(data[i]=='(')
        depth+=1
      else
        if(data[i]==')')
          depth-=1
        else
          if(data[i]=='\"')
            d_mark =!mark
          else
            if(data[i]=='\'')
              mark =!mark
            else
              if(type==0)
                if(depth == 1 and data[i] == ',' and !mark and !d_mark)
                  data[i] = '-&-';
                end
              else
                if(data[i] == ',' and !mark and !d_mark and depth == 0)
                  data[i] = '-&-';
                end
              end
            end
          end
        end
      end
    end
    data
  end
end


class Insert
  @table_name

  def initialize(data)
    data.strip
    if(data.start_with? 'c')
      column_data = ""
    else
      data = data.split("values")
      column_data = data[1]
      data = data[0]
    end
    if(column_data == "")
      reg = /create[\s]+table[\s]+([\w]+)[\s]*\(([\w\s\`\-\&\,\(\)\'\"\u4E00-\u9FFF\[\]]+)\)/#([\w\=\s]*);/
      p reg =~ data
      p $1
      p $2.strip
      return
    end
    column = Array.new
    reg = /insert[\s]+into[\s]+([\w]+)[\s]*\(([\w\s\`\-\&\,\'\"]+)\)/
    reg =~ data
    @table_name = $1
    $2.gsub( /[\`\'\"]/,"").split(",").each do |key|
      column.push(Array.new)
      column.last.push(key)
    end
    array = column_data.gsub(/[\s]/,"").gsub(/;/,"").gsub(/[\(\)]/,"").split(/\-\&\-/)
    array.each do |values|
      values.split(",").each_with_index do |value,index|
        column[index].push(value)
      end
    end
    p column
  end

end

p Insert.new(Reader.new.filter(File.open(ARGV[0]).read.downcase.gsub(/\n/,"")))
#Insert.new(File.open(ARGV[0]).read.downcase.gsub(/\n/,""),"")
#head = File.open(ARGV[0]).read.downcase.split "values"
#data = head[1]
#head = head[0]
#Insert.new head,data
