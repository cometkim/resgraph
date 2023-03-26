@@warning("-27")

open ResGraph__GraphQLJs

let enum_UserStatus = GraphQLEnumType.make({
  name: "UserStatus",
  values: {
    "Online": {GraphQLEnumType.value: "Online"},
    "Offline": {GraphQLEnumType.value: "Offline"},
    "Idle": {GraphQLEnumType.value: "Idle"},
  }->makeEnumValues,
})
let enum_userStatus = GraphQLEnumType.make({
  name: "userStatus",
  values: {
    "Online": {GraphQLEnumType.value: "Online"},
    "Offline": {GraphQLEnumType.value: "Offline"},
    "Idle": {GraphQLEnumType.value: "Idle"},
  }->makeEnumValues,
})
let t_User: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_User = () => t_User.contents
let t_Query: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_Query = () => t_Query.contents

t_User.contents = GraphQLObjectType.make({
  name: "User",
  fields: () =>
    {
      "currentStatus": {
        typ: enum_UserStatus->GraphQLEnumType.toGraphQLType->nonNull,
        resolve: makeResolveFn((src, args, ctx) => {Schema.UserFields.currentStatus(src)}),
      },
      "name": {
        typ: Scalars.string->Scalars.toGraphQLType->nonNull,
        args: {"includeFullName": {typ: Scalars.boolean->Scalars.toGraphQLType}}->makeArgs,
        resolve: makeResolveFn((src, args, ctx) => {
          Schema.UserFields.name(
            src,
            ~includeFullName=args["includeFullName"]->Js.Nullable.toOption,
          )
        }),
      },
      "id": {
        typ: Scalars.id->Scalars.toGraphQLType->nonNull,
        resolve: makeResolveFn((src, args, ctx) => {Schema.UserFields.id(src)}),
      },
      "age": {
        typ: Scalars.int->Scalars.toGraphQLType->nonNull,
        resolve: makeResolveFn((src, _args, _ctx) => src["age"]),
      },
    }->makeFields,
})
t_Query.contents = GraphQLObjectType.make({
  name: "Query",
  fields: () =>
    {
      "me": {
        typ: get_User()->GraphQLObjectType.toGraphQLType,
        resolve: makeResolveFn((src, args, ctx) => {Schema.QueryFields.me(src)}),
      },
    }->makeFields,
})

let schema = GraphQLSchemaType.make({"query": get_Query()})
