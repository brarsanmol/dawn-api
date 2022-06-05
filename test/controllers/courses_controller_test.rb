require 'test_helper'

class CoursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course = courses(:one)
  end

  test 'should get index' do
    get courses_url, as: :json
    assert_response :success
  end

  test 'should create course' do
    assert_difference('Course.count') do
      post courses_url, params: { course: { department: @course.department, faculty: @course.faculty, level: @course.level, name: @course.name, terms: @course.terms } }, as: :json
    end

    assert_response :created
  end

  test 'should show course' do
    get course_url(@course), as: :json
    assert_response :success
  end

  test 'should update course' do
    patch course_url(@course), params: { course: { department: @course.department, faculty: @course.faculty, level: @course.level, name: @course.name, terms: @course.terms } }, as: :json
    assert_response :success
  end

  test 'should destroy course' do
    assert_difference('Course.count', -1) do
      delete course_url(@course), as: :json
    end

    assert_response :no_content
  end
end
