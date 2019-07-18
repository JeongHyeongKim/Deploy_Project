<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- modal -->
<div class="modal fade" id="validate-modal">
	<div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">양식을 채워주세요</h4>
              </div>
              <div class="modal-body">
                <h4 id="validate-message"></h4>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default pull-right" data-dismiss="modal">확인</button>
              </div>
            </div>
            <!-- /.modal-content -->
          </div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->