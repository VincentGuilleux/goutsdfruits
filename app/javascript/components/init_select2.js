import $ from 'jquery';
import 'select2';

const initSelect2 = () => {
  $(document).ready(function() {
    $('.select2').select2(
      );
  });
}

export { initSelect2 } ;
