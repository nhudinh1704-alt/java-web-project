package com.vku.javaweb.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.vku.javaweb.model.User;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {

}