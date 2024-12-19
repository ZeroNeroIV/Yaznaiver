package com.yaznaiver.authentication.controller;

import graphql.GraphQLError;
import graphql.GraphqlErrorBuilder;
import org.springframework.graphql.data.method.annotation.GraphQlExceptionHandler;
import org.springframework.graphql.execution.ErrorType;
import org.springframework.web.bind.annotation.ControllerAdvice;

@ControllerAdvice
public class GlobalExceptionHandler {

    @GraphQlExceptionHandler
    public GraphQLError generalExceptionHandler(Exception e) {
        return GraphqlErrorBuilder
                .newError()
                .message(e.getMessage())
                .errorType(ErrorType.INTERNAL_ERROR)
                .build();
    }

}
