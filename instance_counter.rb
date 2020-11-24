# PointsCounter module
  module PointsCounter
    def self.included(base)
      base.extend ClassMethods
      base.send :include, InstanceMethods
    end

    # ClassMethods module
    module ClassMethods
      attr_accessor :points_count

      def points
        @points_count ||= 0
      end
    end

    # InstanceMethods module
    module InstanceMethods
      protected

      def register_points
        self.class.points_count ||= 0
        sum,sum1,sum2 = 0,0,0
        sums = []
        self.cards.each do |card|
          if card.name =~ (/^[JKQ]{1}/)
            sum += 10
            sums.map!{|value| value + 10}
            sums << sum
          elsif card.name =~ (/^[0-9]{1}/)
            sum += card.name.to_i
            sums.map!{|value| value + card.name.to_i}
            sums << sum
          else
            #sum1 += sum + 1
            if sums.empty?
              sums << sum + 1
              sums << sum + 11
            else
              sumes ||= []
              sums.each{|value| sumes << value + 1; sumes << value + 11;}
              sums = sumes
            end
          end

          print sums
          #puts "sum = #{sum}","sum1 = #{sum1}","sum2 = #{sum2}"
        end

         puts "Max: #{sums.max}"
         puts "Ind: #{sums.index(sums.max)}"

         while sums.max > 21
           puts "Max: #{sums.max}"
           puts "arr: #{sums}"
           sums.delete_at(sums.index(sums.max))
           puts "arr: #{sums}"
           puts "Max: #{sums.max}"
         end

         self.class.points_count = sums.max
        # puts sum,sum1,sum2
        #   if sum1.zero? && sum2.zero?
        #     self.class.points_count = sum
        #   else
        #     if sum1 > sum2 && sum1 <= 21
        #       self.class.points_count = sum1
        #     elsif sum2 > sum1 && sum2 <= 21
        #       self.class.points_count = sum2
        #     end
        #   end
      end
    end
  end
