@interface NSManagedObjectContext (NSManagedObjectContextCategory)

- (NSSet *)fetchObjectsForEntityName:(NSString *)newEntityName
                       withPredicate:(id)stringOrPredicate, ...;

@end
