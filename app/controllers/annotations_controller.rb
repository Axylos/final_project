class AnnotationsController <ApplicationController

  def create
    @document = Document.new(
          body: doc_params[:body],
          title: doc_params[:title],
          author: current_user)

    unless annotation_created
      flash[:errors] << @document.errors.full_messages
      flash[:errors] << @annotation.errors.full_messages if @annotation
    end

    unless params[:annotation][:refs]
      redirect_to document_url(params[:document_id])
    else
      redirect_to new_document_annotation_url(params[:annotation][:parent])
    end
  end

  def new
    @docs = Document.all
    @document = Document.find(params[:document_id])
  end


  private

  def doc_params
    params.require(:annotation).permit(:body, :source_text, :title)
  end

  def join_docs
    src_text = doc_params[:source_text].split
    @annotation = Annotation.create(
      source_document_id: params[:document_id],
      annotation_id: @document.id,
      source_text: src_text)
  end

  def annotation_created
    ActiveRecord::Base.transaction do
      @document.save
      join_docs
    end
  end

end