class Manager::PeDefinesController < ApplicationController
  layout 'manager'

  def index
    pe_defines = PeDefine.all.map{|x|
      DataFormer.new(x).data
    }

    @page_name = 'manager_pe_defines'
    @component_data = {
      pe_defines: pe_defines,
      new_url: new_manager_pe_define_path
    }
    @extend_nav_data = {
      mobile_back_to: manager_path,
      current_title: '诊断项目管理'
    }
  end

  def create
    pe_define = PeDefine.new pe_define_params
    save_model(pe_define) do |x|
      DataFormer.new(x)
        .data
    end
  end

  def edit
    pe_define = PeDefine.find params[:id]

    @page_name = 'manager_pe_defines_edit'
    @component_data = {
      pe_define: DataFormer.new(pe_define).data,
      submit_url: manager_pe_define_path(pe_define),
      cancel_url: manager_pe_defines_path
    }
    @extend_nav_data = {
      mobile_back_to: manager_pe_defines_path,
      current_title: '修改诊断项'
    }
  end

  private
  def pe_define_params
    params.require(:pe_define).permit(:name, fact_group_ids: [])
  end
end
