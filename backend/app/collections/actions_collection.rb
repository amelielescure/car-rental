class ActionsCollection < Array
	def <<(actor)
   if actor.kind_of?(Hash)
    super(Actor.new(actor))
   else
     super
   end
  end
end